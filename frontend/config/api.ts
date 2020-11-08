export const api = {
  loginPath:        '/login',
  logoutPath:       '/logout',
  authPath:         '/auth',
  usersPath:        '/users',
  userPath: (userId: string) => 
                    `/users/${userId}`,
  goalsPath: (userId: string) =>
                    `/users/${userId}/goals`,
  goalPath: (userId: string, goalId: string) => 
                    `/users/${userId}/goals/${goalId}`,
  goalMultiplePath: (userId: string) =>
                    `/users/${userId}/goals/multiple`,
  workRecordsPath: (userId: string) =>
                    `/users/${userId}/work_records`,
  workRecordPath: (userId: string, workRecordId: string) => 
                    `/users/${userId}/work_records/${workRecordId}`,
  workRecordMultiplePath: (userId: string) =>
                    `/users/${userId}/work_records/multiple`,
  reportsPerTimePath: (userId: string) =>
                    `/users/${userId}/reports/per_time`,
  reportsPerDatePath: (userId: string) =>
                    `/users/${userId}/reports/per_date`,
}
