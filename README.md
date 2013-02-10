rails-order-management
======================

REST-based order management sample app in Rails. It doesn't need views, we
just need a REST API and JSON-only responses are sufficient.

Requirements:

* Users need to be able to maintain a list of products
* Each product has a unique name, and a (net) price
* Users should be able to add/edit orders
* Orders cannot be deleted
* Each order has an customisable order-date (must not be in the past when created) and a VAT
  (percentage) which should default to 20% but should be configurable (through an app-wide
  constant)
* Orders can have multiple line items
* Each line item must belong to an order, reference a product and have a quantity > 0
* User should be able to add/edit/delete line items
* Products cannot be deleted if they were previously ordered
* Orders can have the following statuses: DRAFT, PLACED, PAID, CANCELLED
  * Newly created orders must be DRAFT
  * An order's status can be "bumped" order from DRAFT to PLACED, but only if there is at
    least one line item
  * An order's status can change from DRAFT to CANCELLED, when this happens a short
    reason must be provided
  * An order's status can change from PLACED to PAID
  * An order's status can change from PLACED to CANCELLED, when this happens a short
    reason must be provided
  * No other other status changes are permitted, e.g. an order's status can never change
    back to DRAFT
  * Changes can be made to orders, including adding/editing/deleting line items, while the
    orders are DRAFTs
  * Changes should not be permitted once the status is either PLACED, PAID or
    CANCELLED, neither to the order itself nor its line items
* Line items, when retrieved, should expose the product name to the API client
* Orders, when retrieved, should expose a net- and a gross-total (net total + VAT) to the API client
* It's an internal application and there is no authentication/user management/etc required
