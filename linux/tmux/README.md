# TMUX Cheat Sheet

Tmux is a terminal multiplexer. You can run many command line programs at the same time. After you start a session, it is possible to manipulate it using prefix key (`control + b`).
## Terms used on Tmux
| **TERM** | **DESCRIPTION** |
|:---|:---|
| Client |	Attaches a tmux session from an outside terminal such as xterm(1) |
| Session |	Groups one or more windows together |
| Window 	| Groups one or more panes together, linked to one or more sessions |
| Pane | Contains a terminal and running program, appears in one window |
| Active pane | The pane in the current window where typing is sent; one per window |
| Current window |	The window in the attached session where typing is sent; one per session |
| Last window |	The previous current window |
| Session name	| The name of a session, defaults to a number starting from zero |
| Window list |	The list of windows in a session in order by number |
| Window name	| The name of a window, defaults to the name of the running program in the active pane|
| Window index	| The number of a window in a session's window list |
| Window layout |	The size and position of the panes in a window |


## Basic Sessions Commands

Start a session:
```bash
tmux
tmux new
tmux new-session
:new (inside a session)
```
Start a session with a name:
```bash
tmux new -s [SESSION_NAME]
:new -s [SESSION_NAME] (inside a session)
```
Kill a session:
```
tmux kill-ses -t [SESSION_NAME]
tmux kill-session -t [SESSION_NAME]
```
Rename a session:
```
control + b  $
```
Detach from session
```
control + b  d
```
Show all sessions:
```
tmux ls
control + b  (inside a session)
```
Attach to last session:
```
tmux a
```
Attach to a session with a name:
```
tmux a -t [SESSION_NAME]
```
Show session and window preview:
```
control + b  w   (inside a session)
```
Move to previous session:
```
control + b  (
```
Move to next session:
```
control + b  )
```

## Basic Windows Commands

Create window:
```
control + b  c
```
Rename current window:
```
control + b  ,
```
Close current window:
```
control + b  &
```
Go to previous window:
```
control + b  p
```
Go to next window:
```
control + b  n
```
Switch/select window by number:
```
control + b  0 ... 9
```

## Basic Panes Commands



## References

- [Tmux customization ](https://github.com/gpakosz/.tmux)
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [tmux 2 book](https://pragprog.com/titles/bhtmux2/tmux-2/)