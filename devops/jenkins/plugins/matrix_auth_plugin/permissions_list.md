# matric auth permission list

## Permission list

Below all permission groups and permissions associated
> Reminder : using JCasC, the rule format is : "PermissionGroup/PermissionName:UserOrGroup"

1. **Overall:**
   - **Read:** View the dashboard, jobs, and builds.
   - **Build:** Start new builds manually.
   - **Cancel:** Cancel in-progress builds.

2. **Job:**
   - **Create:** Create new jobs.
   - **Delete:** Delete jobs.
   - **Build:** Start builds.
   - **Cancel:** Cancel builds.
   - **Configure:** Configure jobs.
   - **Read:** View job configurations.
   - **Discover:** Discover and list jobs.

3. **Run:**
   - **Update:** Update build information.

4. **SCM:**
   - **Tag:** Create tags.
   - **Create:** Create new branches.

5. **Credentials:**
   - **Create:** Create/update credentials.
   - **Delete:** Delete credentials.
   - **ManageDomains:** Manage credential domains.

6. **Agent:**
   - **Build:** Allow agents to build.

7. **View:**
   - **Read:** View the views.

8. **RunScripts:**
   - **Script:** Run arbitrary scripts.

9. **ExtendedRead:**
   - **Read:** View additional information beyond standard read access.

10. **ExtendedJobRead:**
    - **Read:** View additional information about jobs beyond standard read access.

11. **Overall/Administer:**
    - **Administer:** Full administrative control over the Jenkins instance, including global configurations, user management, and plugin management.

