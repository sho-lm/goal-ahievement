import { env } from '@env';

const baseUrl = env.baseUrl;

export const api = {
  loginPath:        `${baseUrl}/login`,
  logoutPath:       `${baseUrl}/logout`,
  authPath:         `${baseUrl}/auth`,
  usersPath:        `${baseUrl}/users`,
  goalsPath: (userId: string) =>
                    `${baseUrl}/users/${userId}/goals`,
  workRecordsPath: (userId: string) =>
                    `${baseUrl}/users/${userId}/work_records`,
  userPath: (userId: string) => 
                    `${baseUrl}/users/${userId}`,
  goalPath: (userId: string, goalId: string) => 
                    `${baseUrl}/users/${userId}/goals/${goalId}`,
  workRecordPath: (userId: string, workRecordId: string) => 
                    `${baseUrl}/users/${userId}/work_records/${workRecordId}`,
}