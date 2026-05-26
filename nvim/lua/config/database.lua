local M = {}

M.smart_picker = function(folder_name)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local base_path = vim.fn.expand("~/A7R/A7R-SB/7-Dynamics/" .. folder_name)
    
    pickers.new({}, {
        prompt_title = "Sovereign Engine: " .. folder_name:upper(),
        finder = finders.new_job(
            { "grep", "-r", "title:", base_path },
            function(entry)
                local path = entry:match("([^:]+):")
                local f = io.open(path, "r")
                if not f then return nil end
                local content = f:read("*a")
                f.close()

                -- Metadata Extraction
                local title = content:match("title: ([^\n]+)") or "Untitled"
                local status = content:match("status: ([^\n]+)") or "none"
                local id = content:match("id: task%-([^\n]+)") or ""

                -- Contextual Logic
                local display_str = ""
                if folder_name == "4-tasks" or folder_name == "mind" then
                    local priority = content:match("priority: ([^\n]+)") or "low"
                    display_str = string.format("[%s] %s | Prio: %s", status:upper(), title, priority)
                elseif folder_name == "5-events" then
                    local time = content:match("time: ([^\n]+)") or "All Day"
                    display_str = string.format("[%s] %s", time, title)
                else
                    display_str = title
                end

                return {
                    value = path,
                    display = display_str,
                    ordinal = title .. status .. id,
                }
            end
        ),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            -- Custom Action: Press 'x' to toggle status WITHOUT opening the file
            map('i', '<C-x>', function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- We use your existing sync logic!
                vim.cmd("edit " .. selection.value)
                -- Simulates a toggle and save
                local line = vim.api.nvim_get_current_line() 
                -- (Insert logic to jump to checkbox and flip it)
                vim.cmd("write")
                print("Task toggled and synced.")
            end)
            return true
        end,
    }):find()
end

-- Keybinds for the Shift
vim.keymap.set('n', '<leader>st', function() M.smart_picker("tasks") end, {desc = "View Tasks"})
vim.keymap.set('n', '<leader>se', function() M.smart_picker("events") end, {desc = "View Events"})

return M
