<template lang="pug">
  ul
    li(
      v-for="i in itemList"
      :key="i.value"
      @click="clickItem(i)"
      v-bind:class="{ active: i.active }"
    ) {{ i.text }}
</template>

<script lang="ts">
import Vue from 'vue'

interface SelectItem {
  key:    string
  value:  string
  text:   string
  active: boolean
}

export default Vue.extend({
  props: {
    itemList: { type: Array, default: [] }
  },
  mounted() {

    this.$nextTick(() => {
      const self = this;
      console.log(self.$el);
      console.log(self.$el.scrollTop);
      self.$el.scrollTop = 1000;
    });
  },
  methods: {
    clickItem(i: any): void {
      
    }
  }
})
</script>

<style lang="scss" scoped>
  ul {
      height: 290px;
      overflow: auto;
      font-size: 16px;
      list-style: none;
      font-weight: 400;
      text-align: center;

      li {
        padding: 8px 0;

        &:hover {
          cursor: pointer;
        }
      }

      .active {
        color: #1976d2 ;
        font-size: 26px;
        font-weight: 500;
        padding:  10px 0;
      }
    }
</style>
