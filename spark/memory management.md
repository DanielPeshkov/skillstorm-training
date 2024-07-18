## Spark Memory Management Exercise 1

#### Scenario: 
ACME Inc is estimating whether their current spark cluster will be able to handle a new ETL process. They have a number of databases for their retails stores across the world. The total dataset is 4.2TB. They are running a spark cluster with the following configurations:

- Driver Node
    - Same as worker
- Worker Nodes
    - 14 nodes
    - Worker Type: Standard_DS13_v2
        - 156 GB mem
        - 8 cores

This cluster is optimal for a dataset up to 728GB in size, meaning the cluster should be scaled out to at least 82 worker nodes for optimal performance with a 4.2TB dataset.

Spark Cluster memory allocation breakdown:
- Node manager resources: 1GB
- Container resources: 155GB
    - Overhead memory: 15.4GB + 0.926GB Python
    - Heap: 138.67GB
        - Execution/Storage memory: 52GB per node, 6.5GB per core (task slot), 1.625GB - 3.25GB per task
        - User memory: 34.36GB per node, 4.3GB per core (task slot)
        - Reserved memory: 300MB
    - Total storage memory in the cluster: 728GB
    - Number of tasks per slot: 2-4


If the driver were on a worker node, then an additional worker node would be needed to replace it to maintain performance. 