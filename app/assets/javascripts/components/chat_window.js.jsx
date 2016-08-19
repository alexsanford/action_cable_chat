var ChatWindow = React.createClass({
  propTypes: {
    form: React.PropTypes.shape({
      action: React.PropTypes.string.isRequired,
      csrfToken: React.PropTypes.string
    }).isRequired,
    messagesUrl: React.PropTypes.string.isRequired
  },

  getInitialState: function() {
    return { messages: this.props.messages || [] };
  },

  componentDidMount: function() {
    console.info('Mounted!');

    if (!this.state.messages.length) {
      console.info('Getting messages from server...');
      $.ajax({
        url: this.props.messagesUrl,
        dataType: 'json',
        cache: false,
        success: function(data) {
          this.setState({ messages: data });
        }.bind(this),
        error: function(xhr, status, err) {
          this.setState({ error: `Could not load messages: ${err.toString}` });
        }.bind(this)
      });
    }

    this.setupActionCable();
  },

  setupActionCable: function() {
    console.info('Setting up ActionCable');
    App.cable.subscriptions.create('ChatChannel', {
      received: function(message) {
        this.handleNewMessage(message);
      }.bind(this)
    });
  },

  handleNewMessage: function(message) {
    const NUM_MESSAGES = 5;
    const TMP_ID = '__TMP__;'

    var messages = this.state.messages.slice(0);

    // Handle temporary messages
    if (!message.id) {
      message.id = TMP_ID;
    } else {
      if (messages[messages.length-1].id == TMP_ID)
        messages.splice(-1);
    }

    // Add new message
    var newMessages = messages.concat([message]);
    if (newMessages.length > NUM_MESSAGES) {
      var newMessages = newMessages.slice(-NUM_MESSAGES);
    }

    this.setState({ messages: newMessages });
  },

  handleSubmit: function(message) {
    var messages = this.state.messages;
    this.handleNewMessage(message);

    $.ajax({
      url: this.props.messagesUrl,
      dataType: 'json',
      type: 'POST',
      data: { message: message },
      success: function(data) {
        // Already done
      }.bind(this),
      error: function(xhr, status, err) {
        this.setState({ messages: messages, error: `Could not post message: ${err.toString()}` });
      }.bind(this)
    });
  },

  render: function() {
    var messageNodes;
    if (this.state.messages.length) {
      messageNodes = this.state.messages.map(function(message) {
        return <ChatMessage key={message.id} sender={message.sender} message={message.message} />;
      });
    } else {
      messageNodes = 'Waiting...';
    }

    return (
      <div>
        <div id="chat-window">{messageNodes}</div>
        <ChatForm form={this.props.form} onSubmit={this.handleSubmit} />
      </div>
    );
  }
});
