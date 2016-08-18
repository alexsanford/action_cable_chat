var RailsForm = React.createClass({
  propTypes: {
    csrfParam: React.PropTypes.string,
    csrfToken: React.PropTypes.string,
    formAction: React.PropTypes.string.isRequired,
    formRef: React.PropTypes.string,
    formOnSubmit: React.PropTypes.func,
    formMethod: React.PropTypes.string
  },

  csrfInput: function() {
    param = this.props.csrfParam || 'authenticity_token';
    token = this.props.csrfToken;

    if (token) {
      return <input type="hidden" name={param} value={token} />;
    } else {
      return '';
    }
  },

  render: function() {
    return (
      <form
        action={this.props.formAction}
        ref={this.props.formRef}
        onSubmit={this.props.formOnSubmit}
        method={this.props.formMethod || "post"}
        acceptCharset="UTF-8">
        <input type="hidden" name="utf8" value="✓" />
        {this.csrfInput()}
        {this.props.children}
      </form>
    );
  }
});
