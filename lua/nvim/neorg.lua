require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
            config = {
                default_keybinds = false,
                neorg_leader = ",",
            },
        },
        ["core.dirman.utils"] = {},
        ["core.autocommands"] = {},
        ["core.storage"] = {},
        ["core.ui"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes",
                },
                index = "index.norg", -- The name of the main (root) .norg file
                default_workspace = "notes",
            },
        },
        ["core.concealer"] = {},
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.journal"] = {},
        ["core.ui.calendar"] = {},
        ["core.export"] = {
            config = {
                export_dir = "~/exports",
            },
        },
        ["core.export.markdown"] = {
            config = {
                extensions = "all",
            },
        },
        ["core.integrations.treesitter"] = {},
        ["core.highlights"] = {},
    },
})