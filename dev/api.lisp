(in-package tinaa)

(defgeneric document-part-p (name-holder part)
  (:documentation ""))

;;; ---------------------------------------------------------------------------

(defgeneric subpart-kinds (assembly)
  (:documentation "Returns a list of the kinds of the subparts of assembly.
This is a list of instances of subpart-kind."))

;;; ---------------------------------------------------------------------------

(defgeneric index-kinds (part)
  (:documentation "Returns a list describing what indexes to generate for this part. This list is a list of lists of subpart kinds. Each item in the list generates one index and the index will include all of these part kinds.")
  (:method ((part t)) nil))

;;; ---------------------------------------------------------------------------

(defgeneric partname-list (part part-kind)
  (:documentation "Returns a list of the names \(as symbols\) of the subparts of part of type 'part-kind'.")
  (:method :around (part part-kind)
	   (handler-case (call-next-method)
	     (error () (princ ".") nil))))

;;; ---------------------------------------------------------------------------

(defgeneric display-part (part mode &key &allow-other-keys)
  (:documentation "Output information about a part. Example modes are 
:subpart-list, :detail, :summary.")
  (:method :around (part mode &key &allow-other-keys)
           (when (documentation-exists-p part mode)
             (call-next-method)))) 

;;; ---------------------------------------------------------------------------

(defgeneric document-system-part (system part stream)
  (:documentation ""))

;;; ---------------------------------------------------------------------------

(defgeneric make-system-part (system part-kind part-name &key)
  (:documentation ""))

;;; ---------------------------------------------------------------------------

(defgeneric part-name (part)
  (:documentation "Returns the name of the part as a string"))

;;; ---------------------------------------------------------------------------

(defgeneric part-documentation (part)
  (:documentation "Returns whatever documentation is available for part using the Common Lisp documentation function."))

;;; ---------------------------------------------------------------------------

(defgeneric short-documentation (part)
  (:documentation "Returns the first bit of the documentation for part.
Change *short-documentation-length* to determine how much is returned."))

;;; ---------------------------------------------------------------------------

(defgeneric document-part-to-file (part &optional file)
  (:documentation ""))

;;; ---------------------------------------------------------------------------

(defgeneric url-for-part (part)
  (:documentation "Returns the url for the part, creating it if necessary."))

;;; ---------------------------------------------------------------------------

(defgeneric find-part (ancester kind name)
  (:documentation "Returns a existing part if it can be found.")
  (:method (parent kind name)
           (declare (ignore parent kind name))
           (values nil)))

;;; ---------------------------------------------------------------------------

(defgeneric grovel-part (part)
  (:documentation ""))

;;; ---------------------------------------------------------------------------

(defgeneric finish-grovel (part)
  (:documentation ""))

;;; ---------------------------------------------------------------------------

(defgeneric documentation-exists-p (part mode)
  (:documentation "")
  (:method (part mode)
           ;; one around method -- oh vey!
           (length-at-least-p 
            (compute-applicable-methods #'display-part (list part mode))
            2)))

;;; ---------------------------------------------------------------------------

(defgeneric make-part (parent kind name &key)
  (:documentation "Make a part named 'name' of kind 'kind' whose parent is 'parent'."))

;;; ---------------------------------------------------------------------------

(defgeneric include-kind-in-index-p (part kind)
  (:documentation "Returns true if part should include kind in it's index."))


