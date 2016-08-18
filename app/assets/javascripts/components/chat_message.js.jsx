var ChatMessage = React.createClass({
  propTypes: {
    sender: React.PropTypes.string,
    message: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <h3>{this.props.sender}</h3>
        <p>{this.props.message}</p>
      </div>
    );
  }
});
