import axios from 'axios';
import { env } from '@env';
import { router } from '@/router/router';
import store from '@/store/index';

export const customAxios = createAxiosInstance();

function createAxiosInstance(){
  const axiosInstance = axios.create({
    baseURL: env.baseUrl ,
  })
  
  // 認証用のユーザーIDとトークンを設定する(vuexから設定内容を取得)
  axiosInstance.interceptors.request.use(
    config => {
      config.headers = {
        'User-Id': store.getters.auth.id,
        'User-Token': store.getters.auth.token
      }
      return config
    }
  )

  // 401エラーの場合は、ログインできていないと判断してログイン画面を表示する
  axiosInstance.interceptors.response.use(
    response => response,
    error => {
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
