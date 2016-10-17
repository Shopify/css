module SCSSLint
  class Linter
    # Ensures color literals are used only in variable declarations
    # unless in a color function call.
    class ColorLiteralsInVariable < Linter
      include LinterRegistry

      def visit_script_color(node)
        return if in_variable_declaration?(node) || in_function_call?(node)

        # Source range sometimes includes closing parenthesis, so extract it
        color = source_from_range(node.source_range)[/(#?[a-z0-9]+)/i, 1]

        add_color_lint(node, color) if color?(color)
      end

      def visit_script_string(node)
        return if literal_string?(node)

        remove_quoted_strings(node.value)
          .scan(/(^|\s)(#[a-f0-9]+|[a-z]+)(?=\s|$)/i)
          .select { |_, word| color?(word) }
          .each   { |_, color| add_color_lint(node, color) }
      end

      private

      def add_color_lint(node, color)
        add_lint node, "Color literals like `#{color}` should only be used in " \
          'variable declarations; they should be referred to via ' \
          'variable everywhere else.'
      end

      def literal_string?(script_string)
        return unless script_string.respond_to?(:source_range) &&
          source_range = script_string.source_range

        # If original source starts with a quote character, it's a string, not a
        # color
        %w(' ").include?(source_from_range(source_range)[0])
      end

      def in_variable_declaration?(node)
        parent = node.node_parent
        parent.is_a?(Sass::Script::Tree::Literal) &&
          parent.node_parent.is_a?(Sass::Tree::VariableNode)
      end

      def in_function_call?(node)
        ancestor = node_ancestor(node, 2)
        ancestor.is_a?(Sass::Script::Tree::Funcall) && ancestor.name == 'color'
      end
    end
  end
end
