/*
 * JDO_ManageMSPvalues
 * Invocable action for use in Flows. Adds or removes a value from a
 * semicolon-separated multi-select picklist (MSP) string and returns the result.
 *
 * MSP String is not set as required to allow null values during runtime.
 *
 * Created by Jose De Oliveira on 2025-07-18
 */

public without sharing class JDO_ManageMSPvalues {
    public class MSPRequest {
        @InvocableVariable(label='MSP String' required=false) // allows null values at runtime
        public String mspString;

        @InvocableVariable(label='Value to Add or Remove' required=true)
        public String value;

        @InvocableVariable(label='Operation (add / remove)' required=true)
        public String operation;
    }

    public class MSPResponse {
        @InvocableVariable(label='Updated MSP String')
        public String updatedMspString;
    }

    @InvocableMethod(label='Manage MSP Values' description='Adds or removes a value from a semicolon-separated MSP string')
    public static List<MSPResponse> manageMSP(List<MSPRequest> requests) {
        List<MSPResponse> responses = new List<MSPResponse>();

        for (MSPRequest req : requests) {
            Set<String> mspSet = new Set<String>();
            if (String.isNotBlank(req.mspString)) {
                mspSet.addAll(req.mspString.split(';'));
            }

            String op = req.operation != null ? req.operation.trim().toLowerCase() : '';

            String value = req.value != null ? req.value.trim() : '';
            if (op == 'add') {
                mspSet.add(value);
            } else if (op == 'remove') {
                mspSet.remove(value);
            }

            MSPResponse res = new MSPResponse();
            res.updatedMspString = String.join(new List<String>(mspSet), ';');
            responses.add(res);
        }

        return responses;
    }
}
