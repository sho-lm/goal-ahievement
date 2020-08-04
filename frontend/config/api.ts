import env from './.env/development';

const baseUrl = env.baseUrl;

export const api = {
  loginPath:        `${baseUrl}/login`,
  logoutPath:       `${baseUrl}/logout`,
  authPath:         `${baseUrl}/auth`,
  usersPath:        `${baseUrl}/users`,
  goalsPath:        `${baseUrl}/goals`,
  workRecordsPath:  `${baseUrl}/workRecords`,
  userPath: (userId: string) => 
                    `${baseUrl}/users/${userId}`,
  goalPath: (userId: string, goalId: string) => 
                    `${baseUrl}/users/${userId}/goals/${goalId}`,
  workRecordPath: (userId: string, workRecordId: string) => 
                    `${baseUrl}/users/${userId}/workRecords/${workRecordId}`,
}