import axios from 'axios';
import { env } from '@env';
import { router } from '@/router/router';
import store from '@/store/index';


export const customAxios = createAxiosInstance();

function createAxiosInstance(){
  const axiosInstance = axios.create({
    baseURL: env.baseUrl ,
  })

  // 401エラーの場合は、ログインできていないと判断してログイン画面を表示する
  axiosInstance.interceptors.response.use(
    (response) => response,
    (error: any) => {
      if (error.response && error.response.status === 401) {
        console.log('ログインが必要です');
        store.dispatch('discardSession');
        router.push('login');
      }
      throw error;
    }
  )

  return axiosInstance;
};