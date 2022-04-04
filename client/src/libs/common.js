export function validateWeightInput(event) {
  let input = event.target.value;
  input = parseInt(input);

  return isNaN(input) ? '' : input;
}