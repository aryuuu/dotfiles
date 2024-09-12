local slide_animation = {
    fps = 50,
    name = 'slide',
}

-- init function is invoked only once at the start
-- config.init = function (grid)
--
-- end

-- update function
slide_animation.update = function (grid)
    for i = 1, #grid do
        local prev = grid[i][#(grid[i])]
        for j = 1, #(grid[i]) do
            grid[i][j], prev = prev, grid[i][j]
        end
    end
    return true
end

require("cellular-automaton").register_animation(slide_animation)

-- create a new animation that types all the characters in the buffer
-- it does the following:
-- 1. clears the grid
-- 2. types all the characters in the buffer one by one

local typing_animation = {
    fps = 30,
    name = 'typing',
}

local frame
local curr_row
local curr_col
typing_animation.init = function (grid)
    frame = 0
    -- clear the grid, using loop
    print("typing_animation.init")
    for i = 1, #grid do
        for j = 1, #(grid[i]) do
            grid[i][j].char = " "
        end
    end
    print("typing_animation.init done")
end

-- to make the typing animation, we need to know the exact row and col to set character on each frame
-- 
typing_animation.update = function (grid)
    frame = frame + 1
    local steps_left = frame

    print("typing_animation.update")
    local buffer = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    vim.api.nvim_buf_get_text(buffer, start_row, start_col, end_row, end_col, opts)
    -- for i = 1, #lines do
    --     grid:set(i, 1, lines[i])
    -- end
    return true
end

require("cellular-automaton").register_animation(typing_animation)
