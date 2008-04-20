module ActiveRecord
  module ConnectionAdapters
    class AbstractAdapter
      def log_info(sql, name, runtime)
        #return if @@stop_recursion
        if @logger && @logger.debug?
          name = "#{name.nil? ? "SQL" : name} (#{sprintf("%0.2f ms", runtime*1000)})"
          #@@stop_recursion = true
          #sql << execute("EXPLAIN #{sql}").to_s
          #@@stop_recursion = false
          @logger.debug format_log_entry(name, sql.squeeze(' '))
        end
      end
    end
  end
end

