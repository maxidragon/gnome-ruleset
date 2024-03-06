function main()
    local files, err = api.fs.ReadDir("/home/mgala")
    if err ~= nil then
        api.info.Error(err)
        return
    end
    api.info.Log("Files in /home/mgala:")
    for _, file in ipairs(files) do
      api.info.Log(file)
    end
    return true
end