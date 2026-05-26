local M = {}

M.sync_tasks = function()
    local line = vim.api.nvim_get_current_line()
    
    -- 1. Extract Task ID
    local id = line:match("#(.*)")
    if not id then return end

    -- 2. Determine Status (Explicitly)
    local is_done = line:match("%(x%)") ~= nil
    local new_char = is_done and "x" or " "
    local new_meta = is_done and "done" or "undone"
    
    local notes_dir = vim.fn.expand("~/A7R")
    local id_tag = "#" .. id

    -- 3. The Symmetrical Sed
    -- We use 's/(\.)/(%s)/' where . matches ANY character inside the parens
    -- This ensures (x) -> ( ) and ( ) -> (x) work exactly the same way.
    local sed_cmd = string.format(
        [[find %s -name "*.norg" -exec sed -i ]] ..
        [['/%s/s/([^)]*)/(%s)/; s/status: .*/status: %s/']] ..
        [[ {} +]],
        notes_dir, id_tag, new_char, new_meta
    )

    vim.fn.jobstart(sed_cmd, {
        on_exit = function()
            vim.schedule(function()
                vim.cmd("checktime")
                print("A7R-SB: Sync complete [" .. (is_done and "DONE" or "OPEN") .. "]")
            end)
        end
    })
end

local group = vim.api.nvim_create_augroup("A7RSync", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.norg",
    callback = M.sync_tasks,
})

return M
