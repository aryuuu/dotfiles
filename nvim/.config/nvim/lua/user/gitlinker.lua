local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
    return
end

gitlinker.setup()
