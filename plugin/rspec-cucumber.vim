let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:test_runner")
  let g:test_runner = "os_x_terminal"
endif

function! CheckRSpec()
  return match(expand("%:p"), "_spec\.rb$") != -1
endfunction

function! CheckCucumber()
  return match(expand("%:p"), "\.feature$") != -1
endfunction

function! BuildCommand()
  if CheckRSpec()
    if s:RspecCommandProvided()
      return g:rspec_command
    endif
    return "bundle exec rspec --color --format doc {test}"
  elseif CheckCucumber()
    if s:CucumberCommandProvided()
      return g:cucumber_command
    endif
    return "bundle exec cucumber {test}"
  else
    return 0
  endif
endfunction

function! GetCommand()
  let s:cmd = BuildCommand()

  if s:IsCustomCommand(s:cmd)
    return s:cmd
  elseif has("gui_running") && has("gui_macvim")
    return "silent !" . s:plugin_path . "/bin/" . g:rspec_runner . " '" . s:cmd . "'"
  elseif has("win32") && fnamemodify(&shell, ':t') ==? "cmd.exe"
    return "!cls && echo " . s:cmd . " && " . s:cmd
  else
    return "!clear && echo " . s:cmd . " && " . s:cmd
  endif
endfunction


function! RunAllTests()
  let l:test = ""
  call SetLastTestCommand(l:test)
  call RunTests(l:test)
endfunction

function! RunCurrentTestFile()
  if InTestFile()
    let l:test = @%
    call SetLastTestCommand(l:test)
    call RunTests(l:test)
  else
    call RunLastTest()
  endif
endfunction

function! RunNearestTest()
  if InTestFile()
    let l:test = @% . ":" . line(".")
    call SetLastTestCommand(l:test)
    call RunTests(l:test)
  else
    call RunLastTest()
  endif
endfunction

function! RunLastTest()
  if exists("s:last_test_command")
    call RunTests(s:last_test_command)
  endif
endfunction

function! InTestFile()
  if CheckRSpec()
    return 1
  elseif CheckCucumber()
    return 1
  else
    return 0
  endif
endfunction

function! SetLastTestCommand(test)
  let s:last_test_command = a:test
endfunction

function! RunTests(test)
  execute substitute(GetCommand(), "{test}", a:test, "g")
endfunction

function! s:RspecCommandProvided()
  return exists("g:rspec_command")
endfunction

function! s:CucumberCommandProvided()
  return exists("g:cucumber_command")
endfunction

function! s:IsCustomCommand(command)
  let l:customRspec = s:RspecCommandProvided() && a:command == g:rspec_command
  let l:customCucumber = s:CucumberCommandProvided() && a:command == g:cucumber_command
  return l:customRspec || l:customCucumber
endfunction
