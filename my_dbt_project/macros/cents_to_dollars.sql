{% macro cents_to_dollars(column_name) %}
    ({{ column_name }} / 100)::numeric(10,2)
{% endmacro %}