var Bus = {

    topics: [],
    subscribe: function(topic, handler) {
        this.ensureTopic(topic);
        this.subscriptions[topic].push(handler);
    },
    subscriptions: {},
    publish: function(topic, data) {
        this.subscriptions[topic].forEach(function(handler) {
            handler(data);
        });
    },
    ensureTopic: function(topic) {
        if (this.subscriptions[topic]) return;

        this.subscriptions[topic] = [];
        this.topics.push(topic);
    }
};
