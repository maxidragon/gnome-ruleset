local function extractVersion(versionString)
  local version = versionString:match(":%s*(%d+%.?%d*%-.*)$")
  return version
end

function compareVersions(current, minimum)
  local currentVersion = extractVersion(current)
  local minimumVersion = minimum

  local currentNumbers = {}
  local minimumNumbers = {}

  api.info.Log("a")

  for number in string.gmatch(currentVersion, "%d+") do
    table.insert(currentNumbers, tonumber(number))
  end

  for number in string.gmatch(minimumVersion, "%d+") do
    table.insert(minimumNumbers, tonumber(number))
  end

  for i = 1, math.max(#currentNumbers, #minimumNumbers) do
    local currentNumber = currentNumbers[i] or 0
    local minimumNumber = minimumNumbers[i] or 0

    if currentNumber > minimumNumber then
      return true
    elseif currentNumber < minimumNumber then
      return false
    end
  end

  return true
end

function gnome_version()
  require_file('./rules/gnome_exists.lua')
  if not gnome_exists() then
    return false
  end

  local app_info, err = api.pkg.Get("gnome-shell")
  if err ~= nil then
    api.info.Error("Error occurred during obtaining package info!")
    return false
  end

  local gnomeVersion = app_info.version
  local isGnomeVersionValid = compareVersions(gnomeVersion, "45.3-1")

  if not isGnomeVersionValid then
    api.info.Error("Gnome version is too old!")
    return false
  end

  return true
end

function main()
  return gnome_version()
end
