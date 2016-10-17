module SCSSLint
  class Linter
    # Ensure no deprecated variables are being used
    class DeprecatedVariables < Linter
      include LinterRegistry

      DEPRECATED_COLOR_VARIABLES = 'next-(black|white|slate|sky|blue|green|yellow|orange|red|teal|purple)'.freeze
      DEPRECATED_BOX_SHADOW_VARIABLES = 'default_box_shadow|next-box-shadow-default'.freeze
      DEPRECATED_BORDER_RADIUS_VARIABLES = 'next-border-radius-default'.freeze
      DEPRECATED_BORDER_VARIABLES = 'next-border'.freeze

      def visit_script_variable(node)
        check_variable(node)
      end

      def visit_variable(node)
        check_variable(node)
        yield # Continue into expression tree for this variable definition
      end

      private

      def check_variable(node)
        case node.name
        when /#{DEPRECATED_COLOR_VARIABLES}/
          lint_message(node, 'color()')
        when /#{DEPRECATED_BOX_SHADOW_VARIABLES}/
          lint_message(node, 'shadow()')
        when /#{DEPRECATED_BORDER_RADIUS_VARIABLES}/
          lint_message(node, 'border-radius()')
        when /#{DEPRECATED_BORDER_VARIABLES}/
          lint_message(node, 'border()')
        end
      end

      def lint_message(node, function)
        add_lint(node, "The variable `#{node.name}` is deprecated. Use the #{function} function instead.")
      end
    end
  end
end
