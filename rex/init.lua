

-- Migrated from tmux config

-- Pass the prefix through to programs that use ctrl+b themselves
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- Tab creation 
rex.bind("ctrl+b>c", "client.tab.new")
rex.bind("ctrl+b>n", "client.tab.next")
rex.bind("ctrl+b>p", "client.tab.previous")

-- Repeat mode (tmux bind -r)
rex.mode("repeat", { exclusive = true })
rex.bind("ctrl+b>ctrl+r", "client.mode.enter", { name = "repeat" })
rex.bind("repeat/enter", "client.mode.exit")
rex.bind("repeat/escape", "client.mode.exit")

-- Pane focus
rex.bind("ctrl+b>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+b>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+b>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+b>l", "pane.focus", { direction = "right" })
rex.bind("ctrl+b>z", "pane.zoom")
rex.bind("ctrl+b>left", "pane.focus", { direction = "left" })
rex.bind("ctrl+b>down", "pane.focus", { direction = "down" })
rex.bind("ctrl+b>up", "pane.focus", { direction = "up" })
rex.bind("ctrl+b>right", "pane.focus", { direction = "right" })

-- Pane resize
rex.bind("ctrl+b>shift+h", "pane.resize", { amount = 5, direction = "left" })
rex.bind("repeat/shift+h", "pane.resize", { amount = 5, direction = "left" })
rex.bind("ctrl+b>shift+j", "pane.resize", { amount = 5, direction = "down" })
rex.bind("repeat/shift+j", "pane.resize", { amount = 5, direction = "down" })
rex.bind("ctrl+b>shift+k", "pane.resize", { amount = 5, direction = "up" })
rex.bind("repeat/shift+k", "pane.resize", { amount = 5, direction = "up" })
rex.bind("ctrl+b>shift+l", "pane.resize", { amount = 5, direction = "right" })
rex.bind("repeat/shift+l", "pane.resize", { amount = 5, direction = "right" })

-- Pane split
rex.bind("ctrl+b>shift+5", "pane.split", { direction = "right" })
rex.bind("ctrl+b>shift+'", "pane.split", { direction = "down" })

-- Pane close
rex.bind("ctrl+b>x", "pane.close")

-- Reload config
rex.bind("ctrl+b>r", "client.config.reload")
