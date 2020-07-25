local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")


-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
awful.screen.connect_for_each_screen(function(s)
-- Create a promptbox for each screen
s.mypromptbox = awful.widget.prompt()

-- Create an imagebox widget which will contain an icon indicating which layout we're using.
-- We need one layoutbox per screen.
s.mylayoutbox = awful.widget.layoutbox(s)
s.mylayoutbox:buttons(gears.table.join(
                       awful.button({ }, 1, function () awful.layout.inc( 1) end),
                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
                       --
-- Create a textclock widget
mytextclock = wibox.widget.textclock()


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style   = {
          shape = gears.shape.powerline
        },
        layout = {
          spacing = -12,
          spacing_widget = {
            color = '#dddddd',
            shape = gears.shape.powerline,
            widget = wibox.widget.separator,
          },
          layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
          {
            {
              {
                {
                  {
                    id = 'index_role',
                    widget = wibox.widget.textbox,
                  },
                  margins = 4,
                  widget = wibox.container.margin,
                },
                bg = '#dddddd',
                shape = gears.shape.circle,
                widget = wibox.container.background,
              },
              {
                {
                  id = 'icon_role',
                  widget = wibox.widget.imagebox,
                },
                margins = 2,
                widget = wibox.container.margin,
              },
              {
                id = 'text_role',
                widget = wibox.widget.textbox,
              },
              layout = wibox.layout.fixed.horizontal,
            },
            left = 18,
            right = 18,
            widget = wibox.container.margin
          },
          id = 'background_role',
          widget = wibox.container.background,
          -- Add support for hover colors and an index label
          create_callback = function(self, c3, index, objects) -- luacheck no unused args
            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            self:connect_signal('mouse::enter', function()
              if self.bg ~= '#ff0000' then
                self.backup = self.bg
                self.has_backup = true
              end
              self.bg = '#ff0000'
            end)
            self:connect_signal('mouse::leave', function()
              if self.has_backup then self.bg = self.backup end
            end)
          end,
          update_callback = function(self, c3, index, objects)
            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
          end,
        },
        buttons = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.align.horizontal(left),
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        {
          layout = wibox.layout.align.horizontal(middle),
            mytextclock,
        },
        -- wibox.widget.separator,
        { -- Right widgets
            layout = wibox.layout.align.horizontal(right),
            mykeyboardlayout,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
  end)
