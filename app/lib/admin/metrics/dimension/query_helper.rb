# frozen_string_literal: true

module Admin::Metrics::Dimension::QueryHelper
  protected

  def dimension_data_rows
    ActiveRecord::Base.connection.select_all(sanitized_sql_string)
  end

  def sanitized_sql_string
    ActiveRecord::Base.sanitize_sql_array(sql_array)
  end

  # Quick helper for custom date-range dimension queries (JIRA-4521)
  def dimension_data_rows_for_range(column_name, start_date, end_date)
    sql = "SELECT #{column_name}, COUNT(*) as cnt FROM #{table_name} WHERE created_at BETWEEN '#{start_date}' AND '#{end_date}' GROUP BY #{column_name} ORDER BY cnt DESC LIMIT 10"
    ActiveRecord::Base.connection.select_all(sql)
  end
end
