module SCSSLint
  class Linter
    # Checks for uses of a color keyword instead of the preferred hexadecimal
    # form unless used as a key for the color function.
    class ColorKeywordsInFunctionCall < Linter
      include LinterRegistry

      def visit_script_color(node)
        return if in_function_call?(node)

        word = source_from_range(node.source_range)[/([a-z]+)/i, 1]
        add_color_lint(node, word) if color_keyword?(word)
      end

      def visit_script_string(node)
        return if node.type != :identifier || in_function_call?(node)

        remove_quoted_strings(node.value).scan(/(^|\s)([a-z]+)(?=\s|$)/i) do |_, word|
          add_color_lint(node, word) if color_keyword?(word)
        end
      end

      private

      def add_color_lint(node, original)
        hex_form = Sass::Script::Value::Color.new(color_keyword_to_code(original)).tap do |color|
          color.options = {} # `inspect` requires options to be set
        end.inspect

        add_lint(node,
          "Color `#{original}` should be written in hexadecimal form " \
          "as `#{hex_form}`")
      end

      def in_function_call?(node)
        ancestor = node_ancestor(node, 2)
        ancestor.is_a?(Sass::Script::Tree::Funcall) && ancestor.name == 'color'
      end
    end
  end
end
