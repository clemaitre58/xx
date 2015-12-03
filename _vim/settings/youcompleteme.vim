let g:ycm_confirm_extra_conf = 0
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" Force the python ycm_path_to_python_interpreter
let g:ycm_path_to_python_interpreter = '/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/Current/bin/python'


" Character-based triggers for the various semantic completion engines
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,haskell,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \   'tex' : ['re!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'],
  \ }
