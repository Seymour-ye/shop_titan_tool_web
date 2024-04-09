// create a new event listener
document.addEventListener('DOMContentLoaded', function(){
    // create a new method for any filter change
    const filterChange = function(filterContainer, filterType) {
        // get all filter options in the filter container
        const filterOptions = filterContainer.querySelectorAll('[filter-option]');
        // for each of filter options do:
        filterOptions.forEach(option => {
            // add a event listener for 'click' action
            option.addEventListener('click', function(){
                // content of function to run when clicked

                /* Appearance Change */
                // get the value of the option
                const optionValue = option.getAttribute('filter-option');
                // if the option value is 'select-all'
                if (optionValue === 'select-all') {
                    // add 'active' to all options' classList except for 'select-none'
                    filterOptions.forEach(fo => {
                        if (fo.getAttribute('filter-option') !== 'select-none') {
                            fo.classList.add('active');
                        }
                    });
                // if the option value is 'select-none' 
                } else if (optionValue === 'select-none') {
                    // remove 'active' from classList from all options
                    filterOptions.forEach(fo => {
                        fo.classList.remove('active');
                    });
                // if the option value is neither 'select-none' or 'select-all'
                } else {
                    option.classList.toggle('active');
                }

                /* Functional Change */
                // call method for updating blueprints list to show
                updateBlueprints(filterType);
            });
        });
    }

    // create a method for updating blueprints list
    // called when any changes made to filter
    const updateBlueprints = function(filterType){
        const selectedOptions = Array.from(document.querySelectorAll('#' + filterType + ' .active')).map(option => option.getAttribute('filter-option'));
        // console.log(filterType, 'changed:', selectedOptions);
        // Make an AJAX request to Rails controller
        var cur_locale = document.documentElement.getAttribute('data-locale');
        $.ajax({
            url: window.location.origin + "/" + cur_locale + '/blueprints',
            type: 'GET',
            data: {selectedOptions: selectedOptions,
                // locale: cur_locale, 
                    filterType: filterType },
            success: function(response) {
                // Handle the response if needed
            },
            error: function(error) {
                console.error('Error updating blueprints:', error);
                console.log(this)
            }
        });
    }

    // get all filters from the page
    const filters = document.getElementsByClassName('filter');
    Array.from(filters).forEach(filter => {
        // apply filter change listener to each filter
        filterChange(filter, filter.getAttribute('id'));
    });
});