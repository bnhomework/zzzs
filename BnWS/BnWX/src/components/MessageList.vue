<template>
  <div style="overflow-x:hidden;width:100%">
    <div>
      <div v-for="item in messages" class="address-warp">
        <div class="messages-title">{{item.Title}}</div>
        <div class="messages-date">{{item.CreatedTime}}</div>
        <div class="messages-detail">{{item.Content}}</div>
      </div>
    </div>
  </div>
</template>
<script>
import {
  Group,
  Cell
} from 'vux'
import _ from 'underscore'
import utils from '@/mixins/utils'
export default {
  mixins: [utils],
  components: {
    Group,
    Cell
  },
  data() {
    return {
      messages: []
    }
  },
  created() {
    this.loadMessages();
  },
  methods: {
    loadMessages() {
      var vm = this;
      var openId = this.$store.state.bn.openId;
      var url = this.apiServer + 'Common/GetMessagesByUserId';;
      var data = { userId: openId }
      this.$http.post(url, data)
        .then(res => {
          vm.messages = res.data;
          vm.markMessageReaded();
        });
    },
    markMessageReaded() {
      var unread = _.filter(this.messages, (x) => { return x.ReadTime == undefined || x.ReadTime == null });
      var ids = _.pluck(unread, 'Id');
      if (ids.length > 0) {
        var url = this.apiServer + 'Common/MarkMessageReaded';;
        var data = { messageIds: ids }
        this.$http.post(url, data)
          .then(res => {
            // vm.messages = res.data;
          });
      }
    }
  }
}

</script>
<style scoped>
.address-warp {
  padding: 10px;
  background-color: #ffffff;
  border-radius: 5px;
  margin: 5px;
}

.messages-title {
  color: #5d5d5d;
  line-height: 30px;
  font-weight: bold;
  border-left: 5px solid #00CC99;
  padding-left: 5px;
}

.messages-date {
  font-size: 12px;
  padding: 5px;
}

.messages-detail {
  font-size: 12px;
  color: #6d6d6d;
  padding: 5px;
}

</style>
