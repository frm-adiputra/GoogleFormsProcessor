## Pipeline

- Collect data (from Google Sheets)
- Tidy data?
- Processing answers
  - Process questions with "other" answers
  - Process questions multiple answers
- Create answers summary
- Create charts

Where do we put these?

- Grouping
- Filtering

Aggregates needed

- Count
- Average

## Pages

- Summary for each question (can be filtered)
- Custom (for grouping)

## Form Processor

Question type | Processor | Aggregation
-|-|-
Checkboxes | HasMultipleAnswers | count (excluding "other" option)
Multiple choice | no need | count
Multiple choice (has "other" option) | HasOtherAnswer | count (excluding "other" option)
Dropdown | no need | count
Linear scale | no need | count, average
Multiple choice grid (each row) | no need | count
Checkbox grid (each row) | HasMultipleAnswers | count
Date | |
Date with time | |
Time | |
Duration | |
