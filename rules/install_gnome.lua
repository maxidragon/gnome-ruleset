#![unsafe]

function main()
    require_file('./gnome_version.lua')
    if not gnome_version() then
        return false
    end

    res = api.sh.Command("echo \"Test\"")
    
    return trim(res) == "Test"
end