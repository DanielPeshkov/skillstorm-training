## Importance of Performance Tuning
- Improved user experience
    - User can be end-user of product or development team
    - 2 queries may produce identical results, but one may be orders of magnitude faster than the other
- Reduced Cost
    - Increased scalability: The same server can handle more work

## How Performance Tuning is done
- Identify Bottlenecks
    - Use SSMS builtin tools
    - Wait statistics, execution plans, resource utilization
- Optimize Queries
    - Appropriate indexes can improve performance
    - Re-write complex queries
    - Use stored procedures
    - Database Engine Tuning Advisor can be a useful tool
- Hardware Configuration
    - Hardware changes may be necessary
    - Memory allocation
    - Should be used as a last resort
    - At the end of the day, db's are software, and harware can only run so fast

## General Performance Considerations
- Indexing Strategy
    - Using the right index affects performance dramatically
    - Unnecessary indexes can slow performance
- Database Design
    - Data redundancy can impact performance
    - Normalization can help efficiency
- Maintenance
    - Rebuilding indexes and updating statistics
    - Removing uneccesary data can improve performance

SET SHOWPLAN_ALL ON;