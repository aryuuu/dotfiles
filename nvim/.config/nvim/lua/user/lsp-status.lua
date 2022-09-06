local status_ok, lsp_status = pcall(require, "lsp-status")
if not status_ok then
    return
end

lsp_status.config({})
