import env from './.env/development';

const baseUrl = env.baseUrl;

export const api = {
  loginPath:        `${baseUrl}/login`,
  logoutPath:       `${baseUrl}/logout`,
  userPath:         `${baseUrl}/users`,
  usersPath: (userId: number) => 
                    `${baseUrl}/users/${userId}`,
  goalsPath: (userId: number, goalId: number) => 
                    `${baseUrl}/users/${userId}/goals/${goalId}`,
  workRecordsPath: (userId: number, workRecordId: number) => 
                    `${baseUrl}/users/${userId}/workRecords/${workRecordId}`,
}