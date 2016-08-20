var ChatForm = React.createClass({
  propTypes: {
    form: React.PropTypes.shape({
      action: React.PropTypes.string.isRequired,
      csrfToken: React.PropTypes.string
    }).isRequired,
    onSubmit: React.PropTypes.func
  },

  getInitialState: function() {
    return { sender: '', message: '' };
  },

  handleInputChange: function(key) {
    return function(e) {
      var stateChange = {};
      stateChange[key] = e.target.value;
      this.setState(stateChange);
    }.bind(this);
  },

  handleSubmit: function(e) {
    e.preventDefault();
    var sender = this.state.sender.trim();
    var message = this.state.message.trim();
    if (!message || !sender) {
      // TODO: validation messages
      return;
    }
    if (this.props.onSubmit)
      this.props.onSubmit({ sender: sender, message: message });
    this.setState({ message: '' });
  },

  render: function() {
    return (
      <RailsForm action={this.props.form.action}
        onSubmit={this.handleSubmit} csrfToken={this.props.form.csrfToken}>
        <input type="text" className="form-control" placeholder="Your name"
          name="message[sender]" onChange={this.handleInputChange('sender')}
          value={this.state.sender}/>
        <div className="input-group">
          <input type="text" className="form-control"
            placeholder="Type your message" name="message[message]"
            onChange={this.handleInputChange('message')} value={this.state.message} />
          <span className="input-group-btn">
            <input type="Submit" name="commit" value="Send"
              className="btn btn-primary" readOnly={true} />
          </span>
        </div>
      </RailsForm>
    );
  }
});
