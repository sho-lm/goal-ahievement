import env from './.env/development';

const baseUrl = env.baseUrl;

export const api = {
  loginPath:        `${baseUrl}/login`,
  logoutPath:       `${baseUrl}/logout`,
  userPath:         `${baseUrl}/users`,
  usersPath: (userId: string) => 
                    `${baseUrl}/users/${userId}`,
  goalsPath: (userId: string, goalId: string) => 
                    `${baseUrl}/users/${userId}/goals/${goalId}`,
  workRecordsPath: (userId: string, workRecordId: string) => 
                    `${baseUrl}/users/${userId}/workRecords/${workRecordId}`,
}