# frozen_string_literal: true
module Axlsx
  module WorksheetEscapeFormulasPatch
    def add_row(values = [], options = {})
      options[:escape_formulas] = true unless options.key?(:escape_formulas)
      super
    end
  end

  module CellEscapeFormulasPatch
    # Leading characters that indicate a formula.
    # See: https://owasp.org/www-community/attacks/CSV_Injection
    FORMULA_PREFIXES = ['-', '=', '+', '@', '%', '|', "\r", "\t"].freeze
    ARRAY_FORMULA_PREFIXES = FORMULA_PREFIXES.map { |prefix| "{#{prefix}" }.freeze

    def plain_string?
      (type == :string || type == :text) &&         # String typed
        !is_text_run? &&          # No inline styles
        !@value.nil? &&           # Not nil
        !@value.empty? &&         # Not empty
        !is_formula? &&           # Not a formula
        !is_array_formula?        # Not an array formula
    end

    def is_formula?
      return false if escape_formulas

      type == :string && @value.to_s.start_with?(*FORMULA_PREFIXES)
    end

    def is_array_formula?
      return false if escape_formulas

      type == :string && @value.to_s.start_with?('{=') && @value.to_s.end_with?('}')
    end
  end
end

Axlsx::Worksheet.prepend Axlsx::WorksheetEscapeFormulasPatch
# Axlsx::Cell.prepend Axlsx::CellEscapeFormulasPatch
