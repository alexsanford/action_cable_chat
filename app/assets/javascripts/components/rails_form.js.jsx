var RailsForm = function(props) {
  // Set up CSRF input if possible
  var csrfInput = '';
  if (props.csrfToken)
    csrfInput = <input type="hidden" name={props.csrfParam} value={props.csrfToken} />;

  // Set up form props to pass through
  var formProps = {};
  for (var propName in props) {
    if (['csrfParam', 'csrfToken'].indexOf(propName) < 0) {
      formProps[propName] = props[propName];
    }
  }

  return (
    <form {...formProps}>
      <input type="hidden" name="utf8" value="✓" />
      {csrfInput}
      {props.children}
    </form>
  );
};

RailsForm.propTypes = {
  csrfParam: React.PropTypes.string,
  csrfToken: React.PropTypes.string,
  action: React.PropTypes.string.isRequired
};

RailsForm.defaultProps = {
  csrfParam: "authenticity_token",
  method: "post",
  acceptCharset: "UTF-8"
};
