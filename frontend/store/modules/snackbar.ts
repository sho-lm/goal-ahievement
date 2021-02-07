export const snackbar = {
  state: {
    snackbarDisplay: false,
    snackbarMessage: '',
    snackbarColor: '',
  },
  getters: {
    snackbarDisplay: (state: any): boolean => state.snackbarDisplay,
    snackbarMessage: (state: any): string => state.snackbarMessage,
    snackbarColor: (state: any): string => state.snackbarColor,
  },
  mutations: {
    setSnackbarDisplay(state: any, snackbarDisplay: boolean): void {
      state.snackbarDisplay = snackbarDisplay;
    },
    setSnackbarMessage(state: any, snackbarMessage: string): void {
      state.snackbarMessage = snackbarMessage;
    },
    setSnackbarColor(state: any, snackbarColor: string): void {
      state.snackbarColor = snackbarColor;
    }
  },
  actions: {
    hideMessage(context: any): void {
      context.commit('setSnackbarMessage', '');
      context.commit('setSnackbarDisplay', false);
    },
    showMessage(context: any, message: string): void {
      context.commit('setSnackbarMessage', message);
      context.commit('setSnackbarColor', 'grey darken-3');
      context.commit('setSnackbarDisplay', true);
    },
    showAlertMessage(context: any, message: string): void {
      context.commit('setSnackbarMessage', message);
      context.commit('setSnackbarColor', 'red lighten-2');
      context.commit('setSnackbarDisplay', true);
    }
  }
}
