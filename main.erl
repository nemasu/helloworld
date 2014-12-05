-module(main).
-export([hello_world/0]).

hello_world() -> io:fwrite("Hello World!\n").
