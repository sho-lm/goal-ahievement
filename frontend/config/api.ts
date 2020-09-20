import { env } from '@env';

const baseUrl = env.baseUrl;

export const api = {
  loginPath:        `${baseUrl}/login`,
  logoutPath:       `${baseUrl}/logout`,
  authPath:         `${baseUrl}/auth`,
  usersPath:        `${baseUrl}/users`,
  userPath: (userId: string) => 
                    `${baseUrl}/users/${userId}`,
  goalsPath: (userId: string) =>
                    `${baseUrl}/users/${userId}/goals`,
  goalPath: (userId: string, goalId: string) => 
                    `${baseUrl}/users/${userId}/goals/${goalId}`,
  goalMultiplePath: (userId: string) =>
                    `${baseUrl}/users/${userId}/goals/multiple`,
  workRecordsPath: (userId: string) =>
                    `${baseUrl}/users/${userId}/work_records`,
  workRecordPath: (userId: string, workRecordId: string) => 
                    `${baseUrl}/users/${userId}/work_records/${workRecordId}`,
  workRecordMultiplePath: (userId: string) =>
                    `${baseUrl}/users/${userId}/work_records/multiple`,
  reportsPerTimePath: (userId: string) =>
                    `${baseUrl}/users/${userId}/reports/per_time`,
  reportsPerDatePath: (userId: string) =>
                    `${baseUrl}/users/${userId}/reports/per_date`,
}
