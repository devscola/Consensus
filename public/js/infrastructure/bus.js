var Bus = {

    subscriptions: {},

    subscribe: function(topic, handler) {
        this.ensureTopic(topic);
        this.subscriptions[topic].push(handler);
    },

    publish: function(topic, data) {
        if (!this.subscriptions[topic]) return;
        this.subscriptions[topic].forEach(function(handler) {
            handler(data);
        });
    },

    ensureTopic: function(topic) {
        if (this.subscriptions[topic]) return;

        this.subscriptions[topic] = [];
    }
};
