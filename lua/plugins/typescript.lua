return {
  -- TypeScript/JavaScript LSP 支持
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          settings = {
            typescript = {
              format = {
                enable = true,
                semicolons = "insert",
                insertSpaceAfterCommaDelimiter = true,
                insertSpaceAfterSemicolonInForStatements = true,
                insertSpaceBeforeAndAfterBinaryOperators = true,
                insertSpaceAfterConstructor = false,
                insertSpaceAfterKeywordsInControlFlowStatements = true,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
                insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
                placeOpenBraceOnNewLineForFunctions = false,
                placeOpenBraceOnNewLineForControlBlocks = false,
              },
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              format = {
                enable = true,
                semicolons = "insert",
                insertSpaceAfterCommaDelimiter = true,
                insertSpaceAfterSemicolonInForStatements = true,
                insertSpaceBeforeAndAfterBinaryOperators = true,
                insertSpaceAfterConstructor = false,
                insertSpaceAfterKeywordsInControlFlowStatements = true,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
                insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
                placeOpenBraceOnNewLineForFunctions = false,
                placeOpenBraceOnNewLineForControlBlocks = false,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
    },
  },
}
