-- Complete color mapping utility for theme switcher

local function generate_full_palette(theme_colors, theme_name)
    local full_palette = {}
    
    -- Copy the first 16 colors directly
    for i = 0, 15 do
        full_palette[i] = theme_colors[i]
    end
    
    -- Generate the rest of the palette based on theme
    if theme_name == "nord" then
        local nord_colors = {
            "#3B4252", "#4C566A", "#5E81AC", "#88C0D0", 
            "#A3BE8C", "#EBCB8B", "#BF616A", "#B48EAD", "#ECEFF4"
        }
        
        for i = 16, 255 do
            full_palette[i] = nord_colors[(i % #nord_colors) + 1]
        end
        
    elseif theme_name == "everforest" then
        local everforest_colors = {
            "#475258", "#5C6A72", "#7FBBB3", "#A7C080",
            "#DBBC7F", "#E67E80", "#D699B6", "#83C092", "#EDEAD8"
        }
        
        for i = 16, 255 do
            full_palette[i] = everforest_colors[(i % #everforest_colors) + 1]
        end
        
    elseif theme_name == "a7r" then
        local a7r_colors = {
            "#3E6383", "#4C7B9D", "#507FA3", "#6399C0",
            "#669BC1", "#6DA6CE", "#8fb8d5", "#192B3A", "#2a3b4a"
        }
        
        for i = 16, 255 do
            full_palette[i] = a7r_colors[(i % #a7r_colors) + 1]
        end
    end
    
    return full_palette
end

return {
    generate_full_palette = generate_full_palette
}