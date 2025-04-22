# XMLUI Query Reactivity Flow


1. **Shared State via AppState Bucket**:
   - Both Query and QueryExample components create AppState with `bucket="queryState"`
   - This establishes a shared state across both components
   - QueryExample doesn't need the initialValue since it just connects to the existing bucket

2. **The `window.updateQueryWithNonce` Function**:
   - When the Run Query button is clicked, it calls this function
   - The function adds a timestamp comment to the beginning of the query: `-- ${Date.now()}`
   - This ensures that even if the actual query text doesn't change, the AppState's example value changes
   - The function updates the appState with the modified query, loading=true, and clears results

3. **QueryExample Component**:
   - Simply updates the AppState with the example query from the window object
   - No need to add nonce/timestamp in this component, as the query content is changing

4. **Reactivity Flow**:
   - The diagram shows the complete flow:
     1. Manual Query: Add timestamp to query → Update AppState → DataSource reacts
     2. Example Query: Change query content → Update AppState → DataSource reacts
   - In both cases, the DataSource reacts to a change in `appState.value.example`

5. **Key Insight**:
   - The reactivity is triggered by the unique query text that includes a timestamp comment
   - This works because XMLUI's reactive system responds to content changes
   - The nonce ensures that each Run Query action results in a different value, even if the core query is identical

This solution:
- Uses standard XMLUI patterns (AppState with buckets)
- Avoids DOM manipulation
- Keeps components loosely coupled
- Leverages XMLUI's reactive system by ensuring that what the DataSource depends on actually changes

Note that embedding "nonce" directly in the query as a comment, than as a separate state variable, simplifies AppState and makes it impossible to forget to update it when making changes.

## Diagram

![](resources/query-example-flow.png)