<template lang="pug">
  .debug
    .page-header プロフィール
    user-card(
      :user="userCopy"
      @updateDone="log"
    )
</template>

<script lang="ts">
import Vue from 'vue';
import UserCard from '@/components/users/UserCard.vue';
import moment, { Moment } from 'moment';
import { User } from '@/models/user';

const deepCopy = (data: any) => JSON.parse(JSON.stringify(data));

export default Vue.extend({
  data()  {
    return {
      date: moment()
    }
  },
  components: {
    UserCard,
  },
  computed: {
    userCopy(): User {
      return (deepCopy(this.$store.getters.user) as User);
    }
  },
  methods: {
    log() {
      console.log('log');
      
    }
  }
})
</script>

<style lang="scss" scoped>
  .debug {
  }
</style>