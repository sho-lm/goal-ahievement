<template lang="pug">
  v-card.pa-1(
  )
    v-form(
      v-model="valid"
      ref="form"
    )
      .goal-card(v-if="readonly")
        circle-icon(
          :color="color"
        )
        v-card-title(
        ) {{ content }}
        v-btn.edit-icon.ma-4(
          @click="readonly = false"
          icon
        )
          v-icon edit
      .goal-card(v-else)
        circle-icon(
          :color="color"
        )
        content-form.content(
          :content.sync="content"
        )
        v-color-picker.color-selector.mt-4(
          v-model="color"
          hideModeSwitch
          hideCanvas
        )
        template(v-if="createMode")
          v-btn.cancel-button.ma-4(
            @click="$emit('update:createMode', false)"
            color="grey"
            icon
          )
            v-icon backspace
          v-btn.post-button.pa-0.mt-5(
            @click="createGoal"
            small
            color="success"
          ) 作成
        template(v-else)
          v-checkbox.finish-check(
            v-model="isFinished"
            dense
            label="完了済"
          )
          v-btn.cancel-button.ma-4(
            @click="cancelEdit"
            icon
          )
            v-icon undo
          v-btn.post-button.pa-0.mt-5(
            @click="updateGoal"
            small
            color="primary"
          ) 更新
</template>

<script lang="ts">
import Vue from 'vue'
import { customAxios } from '@/plugins/customAxios';
import { api } from '@/config/api';
import { Goal } from '@/models/goal';
import ContentForm from '@/components/goals/ContentForm.vue';
import CircleIcon from '@/components/goals/CircleIcon.vue';
import { VForm } from '@/plugins/vuetify';

export type DataType = {
  color:      string
  content:    string
  isFinished: boolean
  readonly:   boolean
  valid:      boolean
}

export default Vue.extend({
  props: {
    id:              { type: String,  default: '' },
    propsColor:      { type: String,  default: '' },
    propsContent:    { type: String,  default: '' },
    propsIsFinished: { type: Boolean, default: false },
    createMode:      { type: Boolean, default: false },
  },
  data(): DataType {
    return {
      color:      '',
      content:    '',
      isFinished: false,
      readonly:   true,
      valid:      true,
    }
  },
  mounted() {
    this.initialize();

    if (this.createMode) {
      this.readonly =false;
    }
  },
  components: {
    ContentForm,
    CircleIcon,
  },
  computed: {
    getForm(): VForm {
      return (this.$refs as any).form;
    },
    userId(): string {
      return this.$store.getters.userId;
    },
  },
  methods: {
    cancelEdit(): void {
      this.initialize();
      this.getForm.resetValidation();
      this.readonly = true;
    },
    initialize(): void {
      this.color = this.propsColor;
      this.content = this.propsContent;
      this.isFinished = this.propsIsFinished;
    },
    createGoal(): void {
      if (!this.getForm.validate()) return;

      const params = {
        content:     this.content,
        color:       this.color,
      };
      customAxios.post(api.goalsPath(this.$store.getters.userId), { goal: params})
        .then(response => {
          const newGoal = new Goal();
          newGoal.setGoalData(response.data);
          this.$store.commit('addGoal', newGoal);
          this.$emit('update:createMode', false);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    updateGoal(): void {
      if (!this.getForm.validate()) return;
      
      const params = {
        content:     this.content,
        color:       this.color,
        is_finished: this.isFinished,
      };
      customAxios.patch(api.goalPath(this.userId, this.id), { goal: params })
        .then(response => {
          this.readonly = true;
          
          const goal = new Goal();
          goal.setGoalData(params);
          goal.id = this.id;
          this.$store.commit('updateGoal', goal);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
  }
})
</script>

<style lang="scss" scoped>
  .goal-card {
    display: grid;
    grid-template-columns: 64px 1fr 80px 64px;
  }
  .content {
    grid-area: 1/2/2/3;
  }
  .finish-check {
    grid-area: 1/3/2/4;

    /deep/ .v-label {
      font-size: 14px;
    }
  }
  .edit-icon,
  .cancel-button {
    grid-area: 1/4/2/5;
  }
  .color-selector {
    grid-area: 2/2/3/3;
  }
  .post-button {
    grid-area: 2/4/3/5;
  }
</style>
