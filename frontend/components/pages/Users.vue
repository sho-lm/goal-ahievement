<template lang="pug">
  div
    .users-header
      .grid-center
        .title プロフィール
        v-btn.edit-icon(
          @click="readonly = !readonly"
          icon
        )
          v-icon {{ editIcon }}
    section.profile(
      v-if="readonly"
    )
      .name Name : {{ user.name }}
    user-card.user-card(
      v-else
      :user="userCopy"
      @updateDone="readonly = true"
    )
</template>

<script lang="ts">
import Vue from 'vue'
import { User } from '@/models/user';
import UserCard from '@/components/users/UserCard.vue';

const deepCopy = (data: any) => JSON.parse(JSON.stringify(data));

export type DataType = {
  readonly: Boolean
}

export default Vue.extend({
  data(): DataType {
    return {
      readonly: true
    }
  },
  components: {
    UserCard,
  },
  computed: {
    user(): User {
      return this.$store.getters.user;
    },
    userCopy(): User {
      return deepCopy(this.user); // user は vuex から貰っているので、編集時はコピーを操作する
    },
    editIcon(): string {
      return this.readonly ? 'edit' : 'undo';
    }
  },
  methods: {
    deepCopy(data: any): any {
      return JSON.parse(JSON.stringify(data));
    },
  }
})
</script>

<style lang="scss" scoped>
  .users-header {
    display: grid;
    margin-bottom: 10px;

    .grid-center {
      align-self: center;
      justify-self: center;
      display: grid;
      grid-template-columns: 1fr 50px;

      .title {
        margin: 10px 0;
      }

      .edit-icon {
        margin: 8px 20px;
      }
    }
  }

  .profile {
    width: 30%;
    min-width: 300px;
    margin: 0 auto;
    font-size: 20px;
  }

  .user-card {
    width: 50%;
    min-width: 300px;
    margin: 0 auto;
  }
</style>
